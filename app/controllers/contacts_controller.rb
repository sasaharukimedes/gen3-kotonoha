# frozen_string_literal: true

class ContactsController < ApplicationController
  skip_before_action :check_logged_in, only: :new
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to root_path, notice: 'お問い合わせ内容を送信しました'
    else
      redirect_to new_contact_path, alert: 'お問い合わせ内容を送信できませんでした'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
