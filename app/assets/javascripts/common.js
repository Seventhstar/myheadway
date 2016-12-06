// BROWSER DETECTION
	var matched, browser;
	
	$.uaMatch = function( ua ) {
		ua = ua.toLowerCase();

		var match = /(chrome)[ \/]([\w.]+)/.exec( ua ) ||
			/(webkit)[ \/]([\w.]+)/.exec( ua ) ||
			/(opera)(?:.*version|)[ \/]([\w.]+)/.exec( ua ) ||
			/(msie) ([\w.]+)/.exec( ua ) ||
			ua.indexOf("compatible") < 0 && /(mozilla)(?:.*? rv:([\w.]+)|)/.exec( ua ) ||
			[];

		return {
			browser: match[ 1 ] || "",
			version: match[ 2 ] || "0"
		};
	};

	matched = $.uaMatch( navigator.userAgent );
	browser = {};

	if ( matched.browser ) {
		browser[ matched.browser ] = true;
		browser.version = matched.version;
	}

	// Chrome is Webkit, but Webkit is also Safari.
	if ( browser.chrome ) {
		browser.webkit = true;
	} else if ( browser.webkit ) {
		browser.safari = true;
	}

	$.browser = browser;
// BROWSER DETECTION


$(document).ready(function(){
	
	$('.file_inp .btn_add').click(function(event){
		$file_inp = $(this).parents('.file_inp');
		$('input', $file_inp).trigger('click');
		event.preventDefault();
	})

	$(window).load(function(){
		box_cent();
		$('.comments_box .scrollPane_v:visible').each(function(){
			scrollPane_v_init($(this), 30, 100);
		})
	})
	$(window).resize(function(){
		box_cent();
	})

	// inpBtns_init($('input[type="radio"], input[type="checkbox"]'));
	
	$('.select').select();
	
	$('.txt_tags').txtTags();
	

	
	// txtTags plugin
	(function($){
		var methods = {
			init : function(options) {
				this.each(function(){
					var $txt_tags = $(this),
						$tags = $('.tags', this),
						$txt = $('.txt', this),
						$val = $('.val', this),
						$down_list = $('.down_list', this);
					
					$tags.html('');
					
					$(document).click(function(){
						$('.txt_tags').removeClass('extend');
					});
					
					$txt.click(function(event){
						$('.txt_tags').removeClass('extend');
						$txt_tags.toggleClass('extend');
						event.stopPropagation();
					});
					
					$down_list.each(function(){
						if (!$('.dl_i', this).length)
							$(this).wrapInner('<div class="dl_i scrollPane_v"></div>');
						$(this).click(function(event){
							event.stopPropagation();
						});
					})
					
					$('li', $down_list).each(function(event){
						var item_val = $(this).text();
						if ($(this).hasClass('checked')) {
							tag_create(item_val);
						}
						
						$(this).click(function(event){
							if (!$(this).hasClass('checked')) {
								$(this).addClass('checked');
								tag_create(item_val);
							}
						});
					});
					
					
					function tag_create(item_val){
						var tag_match = $('.tag', $tags).filter(function(){
							return $(this).text()==item_val;
						});
						
						$txt_tags.addClass('noEmpty');
						if (!tag_match.length) {
							$tags.append('<span class="tag">'+item_val+'<span class="icon btn_remove"></span></span>');
						}
						
						$('.tag:last .btn_remove', $tags).click(function(event){
							var $tag = $(this).parents('.tag');

							$('li', $down_list).each(function(){
								if ($(this).text() == $tag.text()) {
									$(this).removeClass('checked');
								}
							})
							
							$tag.remove();
							tagsVal_set();

							if (!$('.tag', $tags).length) {
								$txt_tags.removeClass('noEmpty');
							}
							event.stopPropagation();
						});
						
						tagsVal_set();
					}
					
					function tagsVal_set(){
						var tags_val = '';
						$('.tag', $tags).each(function(index){
							var tag_val = $(this).text(),
							sep = ',';
							if (!index) sep = '';
							tags_val =  tags_val + sep + tag_val;
						})
						$val.val(tags_val);
					}
				})
			}
		};

		$.fn.txtTags = function(method) {
			if (methods[method]){
				return methods[method].apply( this, Array.prototype.slice.call(arguments, 1));
			} else if (typeof method === 'object' || ! method) {
				return methods.init.apply(this, arguments);
			} else {
				$.error('Метод с именем ' +  method + ' не существует для jQuery.txtTags');
			} 
		};
	})(jQuery);