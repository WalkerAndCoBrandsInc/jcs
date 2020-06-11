require 'spec_helper'

describe JCS::BaseElement do
  it 'lets you declaratively specify how each field should be formatted in the output XML' do
    class Foo < JCS::BaseElement
      def defaults
        { created_at: nil }
      end

      format :created_at, JCS::DateFormatter.new
    end

    Nokogiri::XML::Builder.new do |builder|
      builder.send('message') do
        Foo.new(created_at: Time.new(2016, 6, 5)).build(builder)
      end

      expect(builder.to_xml).to include('<created-at>20160605</created-at>')
    end
  end
end
