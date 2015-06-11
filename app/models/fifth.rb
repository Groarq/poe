class Fifth

	def initialize(params)
		@cost = [[Cost.new(params[:c1]), Cost.new(params[:c2]), Cost.new(params[:c3]), Cost.new(params[:c4])],
						[Cost.new(params[:c5]), Cost.new(params[:c6]), Cost.new(params[:c7]), Cost.new(params[:c8])],
						[Cost.new(params[:c9]), Cost.new(params[:c10]), Cost.new(params[:c11]), Cost.new(params[:c12])]]
		@supply = [params[:s1].to_i, params[:s2].to_i, params[:s3].to_i]
		@demand = [params[:d1].to_i, params[:d2].to_i, params[:d3].to_i, params[:d4].to_i]
		@matrix = [[], [], []]
	end

	def findMinCost
		min = 50
		retR = 0
		retC = 0
		(0..2).each do |r|
			(0..3).each do |c|
				if @cost[r][c].cost < min && @cost[r][c].convert == true
					min = @cost[r][c].cost
					retC = c
					retR = r
				end
			end
		end
		@cost[retR][retC].convert = false
		return retR,retC
	end

	def conditionEnd
		@suppCon = true
		@demandCon = true
		(0..2).each do |supp|
			if @supply[supp] != 0
				@suppCon = false
			end
		end
		(0..3).each do |dem|
			if @demand[dem] != 0
				@demandCon = false
			end
		end
		return true if @demandCon == true && @suppCon == true
		false
	end

	def score
		sum = 0
		(0..2).each do |ir|
			(0..3).each do |ic|
				sum += @matrix[ir][ic] * @cost[ir][ic].cost
			end
		end
		return sum
	end

	def calculate
		until conditionEnd
			x = findMinCost
			r = x[0]
			c = x[1]

			#check row or column min 
			if @demand[c] < @supply[r]
				@matrix[r][c] = @demand[c]
			else 
				@matrix[r][c] = @supply[r]
			end

			#reduce demand and supply of value
			@demand[c] -= @matrix[r][c]
			@supply[r] -= @matrix[r][c]

			#complete rest column/row to zero if supply/demand equal to zero
			if @demand[c] == 0
				(0..2).each do |ir|
					if @cost[ir][c].convert == true
						@matrix[ir][c] = 0
						@cost[ir][c].convert = false
					end
				end
			end
			if @supply[c] == 0
				(0..3).each do |ic|
					if @cost[r][ic].convert == true
						@matrix[r][ic] = 0
						@cost[r][ic].convert = false
					end
				end
			end
		end 
		@score=score
		return @matrix
	end

end
