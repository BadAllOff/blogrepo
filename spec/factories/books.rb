FactoryGirl.define do

  factory :book do
    author 'Author of book'
    title 'This is Test book'
    description 'This is Test book description'
    draft false
    book_cover_file_name     'css3.jpg'
    book_cover_content_type  'image/jpeg'
    book_cover_file_size     '19789'
    book_cover_updated_at    Time.zone.now
    tags_for_book_list  '4ever, book tag'
  end

end