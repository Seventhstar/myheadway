module BooksHelper

  def book_img_tag(book)
    link_to image_tag(book.img_url), [:edit, book] if book.img_url.present?
  end

end
