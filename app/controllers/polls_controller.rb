#  Copyright 2011/2013 Dextra Sistemas
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
class PollsController < ApplicationController
  unloadable

  before_filter :find_project, :authorize
  before_filter :find_issue, :only => [:bet, :cancel_bet]
  before_filter :get_statuses, :only => [:index, :set_statuses]
  def get_statuses
    @statuses = IssueStatus.find(:all, :order => 'position')
    @eligible_statuses = EligibleStatus.find(:all).collect{ |status| status.status_id }
  end

  def index; end

  def set_statuses
    EligibleStatus.delete_all
    if params[:statuses]
      EligibleStatus.create(params[:statuses].collect{|status| {:status_id => status}})
    end
    flash[:notice] = t(:configuration_successful)
    redirect_to :action => 'index', :tab => 'config'
  end

  def bet
    @bet ||= Bet.new(:votes => 1)
    @bet.issue_id = @issue.id
    @bet.user_id = User.current.id
    @added = false
    @success = false
    if @bet.save
      @issue.bet_votes ||= 0
      @issue.bet_votes += @bet.votes
      @issue.save
      @success = true
      if @bet.votes > 0
        @added = true
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def cancel_bet
    any_votes = (User.current.votes_bet_by_issue(params[:issue_id]) > 0)
    @bet = Bet.new(:votes => any_votes ? -1 : 0)
    bet
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_issue
    @issue = @project.issues.find(params[:issue_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
