function math.normalize(x,y)
	local l=(x*x+y*y)^.5
	if l==0 then
		return 0,0,0
	else
		return x/l,y/l,l
	end
end

function math.length(x,y)
	return (x*x+y*y)^.5
end

function math.sign(n)
	if n > 0 then
		return 1
	elseif n < 0 then
		return -1
	end

	return 0
end

function math.from_polar(theta, r)
  r = r or 1
  return r * math.cos(theta), r * math.sin(theta)
end


function math.dot(vx1, vy1, vx2, vy2)
	return vx1*vx2 + vy1*vy2
end

function math.clamp(a, min, max)
	if min > max then
		min, max = max, min
	end
	return math.max(min, math.min(max, a))
end

function math.ring(a, min, max)
	if min > max then
		min, max = max, min
	end
	return min + (a-min)%(max-min)
end

-- for integer, it will hit min and max
function math.ring_int(a, min, max)
	return math.ring(a, min, max+1)
end

-- function to compare two number regardless of float precision
function math.fp_equal(a,b, precision)
	precision = precision or 0.000001
	return a>(b-precision) and a<(b+precision)
end


function math.angle(x1,y1, x2,y2)
	return math.ring(math.deg(math.atan2(y2-y1, x2-x1))-90, 0, 360)
end


function math.round( a, bracket)
	if not bracket then
		-- bracket = 1
		return math.floor( a + 0.5 )
	end
	
	-- path for additional precision 
	if bracket<1 then
		bracket = 1//bracket
		local half = (a >= 0 and 0.5) or -0.5
		return (a*bracket+half)//1/bracket
	end

	local half = (a >= 0 and bracket/2) or -bracket/2
	return ((a+half)//bracket)*bracket
end

-- use to get a value approching step by step a target
-- return values:
--  value closer to the target
--  bool if the return value is the target 
function math.approach(value,target,step)
	if value==target then
		return value, true
	end

	local d = target-value
	if d>0 then
		value = value + step
		if value >= target then
			return target, true
		else
			return value, false
		end
	elseif d<0 then
		value = value - step
		if value <= target then
			return target, true
		else
			return value, false
		end
	else
		return value, true
	end
end

function math.mid(a, b, c)
	if ((a <= b and b <= c) or (c <= b and b <= a)) then
		return b
	elseif ((b <= a and a <= c) or (c <= a and a <= b)) then
		return a
	else
		return c
	end
end

function math.infinite_approach(at_zero, at_infinite, x_halfway, x)
	return at_infinite - (at_infinite-at_zero)*0.5^(x/x_halfway)
end

function math.bool_to_int(b)
	return b and 1 or 0
end

function math.map(n, start1, stop1, start2, stop2)
	return ((n-start1)/(stop1-start1))*(stop2-start2)+start2
end