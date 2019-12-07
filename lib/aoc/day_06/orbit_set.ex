defmodule AOC.Day06.OrbitSet do
  defstruct [
    orbit_graph: nil,
    body_verts: Map.new()
  ]

  def build(orbit_list) do
    ol = %__MODULE__{
      orbit_graph: :digraph.new([:acyclic])
    }
    Enum.reduce(orbit_list, ol, fn({left,  right}, g) ->
      add_orbit(g, left, right)
    end)
  end

  def build(orbit_list, :undirected) do
    ol = %__MODULE__{
      orbit_graph: :digraph.new([:cyclic])
    }
    Enum.reduce(orbit_list, ol, fn({left,  right}, g) ->
      g
      |> add_orbit(left, right)
      |> add_orbit(right, left)
    end)
  end

  def add_orbit(os, left, right) do
    left_vertex = :digraph.add_vertex(os.orbit_graph, left)
    right_vertex = :digraph.add_vertex(os.orbit_graph, right)
    _ = :digraph.add_edge(os.orbit_graph, right_vertex, left_vertex)
    left_set = Map.put(os.body_verts, left,  left_vertex)
    right_set = Map.put(left_set, right, right_vertex)
    %{
      os |
      orbit_graph: os.orbit_graph,
      body_verts: right_set
    }
  end

  def shortest_path_length(orbit_set, a, b) do
    a_vert = Map.fetch!(orbit_set.body_verts, a)
    b_vert = Map.fetch!(orbit_set.body_verts, b)
    Enum.count(:digraph.get_short_path(orbit_set.orbit_graph, a_vert, b_vert)) - 1
  end

  def count_orbits(orbit_set) do
    com_vert = Map.fetch!(orbit_set.body_verts, "COM")
    Enum.reduce(Map.keys(orbit_set.body_verts), 0, fn(b, acc) ->
      case b do
        "COM" -> acc
        _ ->
          vert = Map.fetch!(orbit_set.body_verts, b)
          acc + Enum.count(:digraph.get_short_path(orbit_set.orbit_graph, vert, com_vert)) - 1
      end
    end)
  end
end
