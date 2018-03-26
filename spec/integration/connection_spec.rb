# frozen_string_literal: true

require_relative '../support/client_tests'

describe 'test' do
  it 'does nothing' do
    expect(1).to eq(1)
    ClientTests.run
  end
end
