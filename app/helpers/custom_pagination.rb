class CustomPagination < WillPaginate::ActionView::LinkRenderer
    def container_attributes
        { class: 'pagination' }
    end
      
      def page_number(page)
        if page == current_page
            tag(:li, tag(:a, page, class: 'page-link'), class: 'page-item active')
        else
            tag(:li, link(page, page, rel: rel_value(page), class: 'page-link'), class: 'page-item')
        end
    end
      
      def gap
        tag(:li, tag(:a, '...', class: 'page-link'), class: 'page-item disabled')
      end
      
      def previous_or_next_page(page, text, classname)
        if page
          tag(:li, link(text, page, class: 'page-link'), class: 'page-item')
        else
          tag(:li, tag(:a, text, class: 'page-link'), class: 'page-item disabled')
        end
      end
      
      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, '&laquo;', 'previous_page')
      end
      
      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(num, '&raquo;', 'next_page')
      end
    
end