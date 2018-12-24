require_relative 'complex_type'

module SoapEnumerator
  class Types
    class Schemas
      # Schema class contains all schema elements as objects.
      #   It dynamically detects schema attributes then generates
      #   attributes for these attributes.
      #   Also, it contains the complexType objects
      #
      # @example:
      #   doc   = Nokogiri::XML(open(https://url/service.php?wsdl))
      #   schema = SoapEnumerator::Types::Schemas::Schema.new(doc)
      #   schema.schema_attributes
      #
      class Schema

        include MetaHelper

        attr_reader :attributes
        attr_reader :complex_types

        def initialize(schema_doc)
          @attributes    = attributes_2_methods(schema_doc)
          @complex_types = get_complex_types(schema_doc)
        end
        
        private
        # get_complex_types method
        #
        # @param [] schema
        #
        # @return [Array<ComplexType>]
        #   return object of [ComplexType] contains the name of the complexType
        #   and array of all existing types. (@see #ComplexType)
        #
        # @todo: find a better search query to include xsd:complexType and s:complexType
        def get_complex_types(schema)
          begin
            schema.search('//xsd:complexType')&.map do |comp_types_doc|
              Types::Schemas::Schema::ComplexType.new(comp_types_doc)
            end
          rescue Nokogiri::XML::XPath::SyntaxError
            schema.search('//s:complexType')&.map do |comp_types_doc|
              Types::Schemas::Schema::ComplexType.new(comp_types_doc)
            end
          rescue Exception => e
            puts "[!] The element 'complexType' Could not be found in the document!"
            puts e.full_message
          end
        end

      end
    end
  end
end