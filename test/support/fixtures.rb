FactoryGirl.define do

  factory :page do
    title            "Just a page"
    meta_title       { self.title }
    meta_description { "Nothing too cool here except the title: #{title}." } 
    meta_keywords    { "just, something, in, a, list, #{title.downcase}" }
  end
  
  factory :content do
    page { Spree::Page.first }
    title "Just some content"
    body  { "Nothing too cool here except the title: #{title}." }
  end

end
