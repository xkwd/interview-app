require 'rails_helper'

RSpec.describe InterviewsController, type: :controller do

  describe InterviewsController do
    it { should route(:get, '/interviews').to(action: :index) }
    it { should route(:get, '/interviews/1').to(action: :show, id: 1) }
  end

end
