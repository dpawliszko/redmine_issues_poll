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

module IssuesPollUserPatch
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)

    base.class_eval do
      has_many :bets
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def can_bet?(project_id)
      project = Project.find(project_id)
      project.enabled_module_names.include?('issues_poll')
    end

    def votes_bet_by_issue(issue_id)
      self.bets.sum(:votes, :conditions => ["issue_id=?", issue_id])
    end
  end
end
