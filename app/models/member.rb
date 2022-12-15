class Member < ApplicationRecord
  
   has_many :loans, dependent: :destroy

   validates :name, presence: true
   validates :ic_number, 
              presence: true, uniqueness: true, 
              format: { with: /\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])/, message: "Format No Kad Pengenalan salah" }
   validates :number, presence: true, uniqueness: true

   scope :ordered, -> { order(name: :asc) }
   
   def self.import_return_count(file)
     
     @counter = 0 
     
     CSV.foreach(file.path) do |row|
       name, ic_number, number = row
       member = Member.create(name: name, ic_number: ic_number, number: number)
       @counter += 1 if member.persisted?
     end
     
     return @counter
     
   end
   
end
