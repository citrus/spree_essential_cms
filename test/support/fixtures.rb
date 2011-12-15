FactoryGirl.define do

  factory :page do
    title            "Just a page"
    meta_title       { self.title }
    meta_description { "Nothing too cool here except the title: #{title}." } 
    meta_keywords    { "just, something, in, a, list, #{title.downcase}" }
  end

end
