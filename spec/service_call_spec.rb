require "spec_helper"

describe ServiceCall do
  it "has a version number" do
    expect(ServiceCall::VERSION).not_to be nil
  end

  context "with attributes and call parameters" do
    class ServiceWithAttributesAndParameters
      include ServiceCall

      attribute :attribute1

      def call(position1, position2, keyword1:, keyword2:)
        {
          attribute1: attribute1,
          position1: position1,
          position2: position2,
          keyword1: keyword1,
          keyword2: keyword2,
        }
      end
    end

    subject { ServiceWithAttributesAndParameters.(1, 2, keyword1: :a, keyword2: :b, attribute1: :z) }

    it "passes attributes to initalize and all other paremters to call" do
      expect(subject).to eq(attribute1: :z, position1: 1, position2: 2, keyword1: :a, keyword2: :b)
    end
  end

  context "with no attributes or call parameters" do
    class ServiceWithoutAttributesAndParameters
      include ServiceCall

      def call
        "Done"
      end
    end

    subject { ServiceWithoutAttributesAndParameters.() }

    it "invokes call" do
      expect(subject).to eq("Done")
    end
  end
end

