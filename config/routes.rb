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

get 'projects/:project_id/polls' => 'polls#index'
post 'projects/:project_id/polls/cancel_bet' => 'polls#cancel_bet'
post 'projects/:project_id/polls/bet' => 'polls#bet'
post 'projects/:project_id/polls/set_statuses' => 'polls#set_statuses'
