class MessagesController < ApplicationController
  before_action :set_subject
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!  # Assurez-vous d'utiliser une méthode d'authentification adaptée
  before_action :check_edit_permission, only: [:edit, :update]


  # GET /messages
  def index
    @messages = @subject.messages.all
  end

  # GET /messages/1
  def show
    @message = Message.find(params[:id])
  end

  # GET /messages/new
  def new
    @subject = Subject.find(params[:subject_id])
    @message = @subject.messages.new(parent_id: params[:parent_id])
  end
  
  
  # GET /messages/1/edit
  def edit
    if @message.created_at < 5.minutes.ago
      redirect_to subject_message_path(@subject, @message), alert: "You can only edit this message within 5 minutes of its creation."
    end
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to subject_path(@subject), notice: 'Message was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  
  # POST /messages
  def create
    @subject = Subject.find_by(id: params[:subject_id])
    return redirect_to subjects_path, alert: "Subject not found." if @subject.nil?
  
    @message = @subject.messages.build(message_params)
    @message.user = current_user # Ensure this assignment is correct, given your user session management
  
    if @message.save
      redirect_to subject_message_path(@subject, @message), notice: 'Message created successfully.'
    else
      render :new
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to subject_path(@subject), notice: 'Message was successfully destroyed.'
  end

  def reply
    @subject = Subject.find(params[:subject_id])  # Assurez-vous d'avoir cette ligne
    @message = @subject.messages.find(params[:id])
    render partial: 'messages/quote_preview', locals: { message: @message }
  end
  

  private
    # Use callbacks to share common setup or constraints between actions
    def set_subject
      @subject = Subject.find_by(id: params[:subject_id])
      if @subject.nil?
        flash[:error] = "Subject not found."
        redirect_to subjects_path and return
      end
    end
    
    def set_message
      @message = @subject.messages.find_by(id: params[:id])
      unless @message
        redirect_to subject_messages_path(@subject), alert: "Message not found."
      end
    end
    

    # Only allow a list of trusted parameters through
    def message_params
      params.require(:message).permit(:content, :user_id, :subject_id, :quote_id, :parent_id)
    end    

    def check_edit_permission
      message = Message.find(params[:id])
      unless current_user.can_edit?(message)
        redirect_to(subject_path(message.subject), alert: "You are not allowed to edit this message.")
      end
    end
end