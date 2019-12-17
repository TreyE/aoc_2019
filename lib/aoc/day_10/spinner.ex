defmodule AOC.Day10.Spinner do
   defstruct [previous: [],  next: [], focus: nil]

   def new([a|rest]) do
     %__MODULE__{
       focus: a,
       next: rest
     }
   end

   def spin(%__MODULE__{previous: [a|rest], next: [], focus: f} = rec) do
    %__MODULE__{
      rec |
      previous: [f],
      next: rest,
      focus: a
    }
   end

   def spin(%__MODULE__{previous: prev, next: [a|rest], focus: f} = rec) do
    %__MODULE__{
      rec |
      previous: prev ++ [f],
      next: rest,
      focus: a
    }
   end

   def spin_to_initial(rec, target_location) do
     current_angle = rec.focus.angle
     new_rec = spin(rec)
     next_angle = new_rec.focus.angle
     case (current_angle > target_location) && (next_angle <= target_location)  do
       false -> spin_to_initial(new_rec, target_location)
       _ -> new_rec
     end
   end

   def zap_and_spin(rec) do
     case AOC.Day10.SpinEntry.zap(rec.focus) do
       :empty -> {:empty, spin(rec)}
       {node, entry} ->
          updated = %__MODULE__{
            rec |
            focus: entry
          }
          {node, spin(updated)}
     end
   end

   def zap_and_spin_until(rec, acc, until_func) do
     zap_result = zap_and_spin(rec)
     {_, new_rec} = zap_result
     case until_func.(zap_result, acc) do
       {:halt, new_acc} -> new_acc
       {:cont, new_acc} ->  zap_and_spin_until(new_rec, new_acc, until_func)
     end
   end
end
