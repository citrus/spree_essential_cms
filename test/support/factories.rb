FactoryGirl.define do

  factory :spree_page, :class => Spree::Page do
    title            "Just a page"
    meta_title       { self.title }
    meta_description { "Nothing too cool here except the title: #{title}." } 
    meta_keywords    { "just, something, in, a, list, #{title.downcase}" }
  end
  
  factory :spree_content, :class => Spree::Content do
    page { Spree::Page.first }
    title "Just some content"
    body  { "Nothing too cool here except the title: #{title}." }
  end

  factory :spree_page_image, :class => Spree::PageImage do
    viewable { Spree::Page.first }
    attachment { sample_image }
  end

end
