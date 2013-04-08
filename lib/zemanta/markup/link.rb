class Zemanta
  class Markup
    class Link
      extend ActiveSupport::Autoload

      autoload :Target

      attr_reader :relevance, :confidence, :entity_type, :target, :anchor

      def initialize(opts = {})
        @relevance   = opts["relevance"]
        @confidence  = opts["confidence"]
        @entity_type = opts["entity_type"]
        @target      = opts["target"].map{ |opts| Target.new(opts) }
        @anchor      = opts["anchor"]
      end

      def above?(relevance, confidence)
        @relevance >= relevance and @confidence >= confidence
      end      
    end
  end
end