class MessagesController < ApplicationController
  before_action :set_subject
  before_action :set_message, only: [:new, :show, :edit, :update, :destroy]
  before_action :authenticate_user!  # Assurez-vous d'utiliser une méthode d'authentification adaptée

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
    @message = @subject.messages.build  # Initializes a new message associated with @subject
  end
  # GET /messages/1/edit
  def edit
    if @message.created_at < 5.minutes.ago
      redirect_to subject_message_path(@subject, @message), alert: "You can only edit this message within 5 minutes of its creation."
    end
  end

  def update
    if @message.created_at >= 5.minutes.ago
      if @message.update(message_params)
        redirect_to subject_path(@subject), notice: 'Message was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to subject_path(@subject), alert: "You can no longer edit this message."
    end
  end
  
  # POST /messages
  def create
    @message = @subject.messages.build(message_params)
    @message.user = current_user  # Assuming you have user authentication and current_user is available
  
    if @message.save
      redirect_to subject_message_path(@subject, @message), notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to subject_path(@subject), notice: 'Message was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_subject
      @subject = Subject.find(params[:subject_id])
    end
    
    def set_message
      @message = @subject.messages.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def message_params
      params.require(:message).permit(:content, :user_id, :subject_id, :quote_id)
    end
end