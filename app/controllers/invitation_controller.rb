class InvitationsController < ApplicationController
  def show
    raise "Got invitaiton #{Invitation.find(params[:id]) }"
  end

end
