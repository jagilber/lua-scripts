local thread = {
  threads = {},
  current = 1
 }
 
 function thread.create(func)
  local t = {}
  t.co = coroutine.create(func)
  function t:stop()
   for i,th in pairs(thread.threads) do
    if th == t then
     table.remove(thread.threads, i)
    end
   end
  end
  table.insert(thread.threads, t)
  return t
 end
 
 function thread:run()
  while true do
   if #thread.threads < 1 then
    return
   end
   if thread.current > #thread.threads then
    thread.current = 1
   end
   coroutine.resume(true, thread.threads[thread.current].co)
   thread.current = thread.current + 1
  end
 end
 
 
 -- example
 
 function sleep()
  event.pull(0.0)
 end
 
 function foo1()
  while true do
 --  sleep()
   print("hey")
  end
 end
 
 function foo2()
  while true do
 --  sleep()
   print("ho")
  end
 end
 
 local t1 = thread.create(foo1)
 local t2 = thread.create(foo2)
 
 thread.run()