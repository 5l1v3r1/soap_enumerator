module SoapEnumerator
  class Types
    class Schemas
      class Schema

        class ComplexType
          # Type class is struct class for xsd:all elements (each element is a Type object).
          class Type
            include MetaHelper

            attr_reader :attributes

            def initialize(tpye_doc)
              @attributes = attributes_2_methods(tpye_doc)
            end
          end

        end
      end
    end
  end
end
