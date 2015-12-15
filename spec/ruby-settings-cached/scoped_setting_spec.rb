require 'spec_helper'

describe RubySettings::ScopedSettings do
  it "extends `CachedSettings`" do
    expect(described_class.ancestors).to include(RubySettings::CachedSettings)
  end
end
