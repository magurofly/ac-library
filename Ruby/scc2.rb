class SCCGraph
	# n 頂点の有向グラフを作る
	# @complexity O(n)
	def initialize(n = 0)
		@n, @graph, @reverse = n, Array.new(n) { [] }, Array.new(n) { [] }
	end

	# 頂点 from から頂点 to へ有向辺を足す
	# @complexity O(1) amortized
	def add_edge(from, to)
		raise "invalid params" unless (0...@n).include? from and (0...@n).include? to
		@graph[from] << to
		@reverse[to] << from
	end

	# 強連結成分を成分ごとにトポロジカルソートして返す
	# @complexity O(@n + @edges.size)
	def scc
		verticles = []
		visited = [false] * @n
		stack = []
		@n.times do |i|
			next if visited[i]
			dfs(@graph, visited, stack, verticles, i)
		end
		groups = []
		visited.fill false
		p verticles
		verticles.each do |t|
			next if visited[t]
			groups << []
			dfs(@reverse, visited, stack, groups.last, t)
		end
		groups
	end

	private

	def dfs(graph, visited, stack, verticles, start)
		visited[start] = true
		stack << start
		while (v = stack.pop)
			verticles << v
			graph[v].each do |u|
				next if visited[u]
				visited[u] = true
				stack << u
			end
		end
	end
end