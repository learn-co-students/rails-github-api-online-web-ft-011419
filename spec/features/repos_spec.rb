require_relative '../spec_helper'

describe 'authentication' do
  it 'displays the username on the page' do
  end
end

describe 'visiting root' do
  before :each do
    page.set_rack_session(token: '1')
  end

  it 'lists repos' do

  end
end
