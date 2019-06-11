# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rating::Config, '.rate_table' do
  context 'when rating.yml does not exist' do
    it { expect(subject.rate_table).to eq 'rating_rates' }
  end if ENV['CONFIG_ENABLED'] != 'true'

  context 'when rating.yml exists' do
    it { expect(subject.rate_table).to eq 'reviews' }
  end if ENV['CONFIG_ENABLED'] == 'true'
end
