
local old_generate_shop_item = generate_shop_item;
local old_generate_shop_wand = generate_shop_wand;

function generate_shop_item( x, y, cheap_item, biomeid_, is_stealable )
	if GameHasFlagRun( "cheap_shops" ) then
		cheap_item = true
	end

    old_generate_shop_item( x, y, cheap_item, biomeid_, is_stealable );
end

function generate_shop_wand( x, y, cheap_item, biomeid_ )
	if GameHasFlagRun( "cheap_shops" ) then
		cheap_item = true
	end

    old_generate_shop_wand( x, y, cheap_item, biomeid_ );
end