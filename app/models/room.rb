class Room < ApplicationRecord
  has_many :term
  has_many :client, through: :term

  default_scope -> { order(:room_number) }

  before_destroy :destroy_terms

  validates :room_number, presence: true,
                          uniqueness: true,
                          numericality: { greater_than_or_equal_to: 0 }                       
  validates :floor, presence: true,
            numericality: { greater_than_or_equal_to: -1 }                       
            
  validates :quantity_of_beds, presence: true,
                               numericality: { greater_than_or_equal_to: 1 }                       
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  enum standard: {normal: 0, higher: 1, highest: 2}

  private
    def destroy_terms
      self.term.destroy_all
    end
end
