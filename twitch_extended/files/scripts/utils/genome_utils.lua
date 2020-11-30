function set_genome_relations(genome_1, genome_2, relation)
	genome_relations = get_content("data/genome_relations.csv")

	lines = get_lines(genome_relations)

	herd_list = split_csv(lines[1])

	genome_key = 0
	genome_item = {}

	for k, v in pairs(lines)do
		items = split_csv(v)
		--print("'"..items[1].."' == '"..genome_1.."'")
		if(items[1] == genome_1)then
			genome_key = k
			genome_item = items
		--	print("Found matching genome: "..items[1])
		end
	end

	if(genome_key ~= 0)then
		for k, v in pairs(genome_item)do
			if(herd_list[k] == genome_2)then
				genome_item[k] = tostring(relation)
			end
		end
		new_string = ""
		for k, v in pairs(genome_item)do
			if(k ~= #genome_item)then
				new_string = new_string..v..","
			else
				new_string = new_string..v
			end
		end
		lines[genome_key] = new_string
		
		genome_content = ""

		for k, v in pairs(lines)do
			genome_content = genome_content..v..string.char(10)
		end
		---print(genome_content)
		set_content("data/genome_relations.csv", genome_content)
		--print(get_content("data/genome_relations.csv"))
	end
end

