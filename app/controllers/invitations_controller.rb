class InvitationsController < ApplicationController

  before_filter :authenticate_user!

  def show
    @invite = Invitation.find(params[:id])

    unless @invite.used?
      @invite.expires = 48.hours.from_now
      @invite.used = true
      @invite.save
    end

    redirect_to :controller => "projects", :action => "show", :id => @invite.project
  end

end
