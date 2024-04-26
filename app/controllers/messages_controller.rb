# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_subject, only: [:create]

  def create
    @message = @subject.messages.new(message_params)

    if @message.save
      redirect_to @subject, notice: "Message was successfully created."
    else
      render "subjects/show"
    end
  end

  private

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end

  def message_params
    params.require(:message).permit(:subject_id, :content, :user_id)
  end

end
