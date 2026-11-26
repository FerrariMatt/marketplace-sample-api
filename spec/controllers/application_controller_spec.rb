require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  it 'inherits from ActionController::API' do
    expect(described_class.superclass).to eq(ActionController::API)
  end
end
