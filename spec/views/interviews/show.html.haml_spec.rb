require 'rails_helper'

RSpec.describe "interviews/show.html.haml", type: :view do
  it 'displays interview details correctly' do
    assign(:interview, Interview.create(title: "Reconstructions change the original",
                                  description: "I'm going to make him an offer he can't refuse"))

    render

    expect(CGI.unescapeHTML(rendered)).to match("Reconstructions change the original")
    expect(CGI.unescapeHTML(rendered)).to match("I'm going to make him an offer he can't refuse")
  end
end
