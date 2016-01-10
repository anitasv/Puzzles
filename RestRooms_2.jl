function solve(arr, k)
    n = length(arr)
    
    if (k == 2)
        return arr[n] - arr[1]
    end
            
    return binary_probe(arr, k, 1, floor(Int, n / 2))
end

function binary_probe(arr, k, start, offset)
   
    (k_l, k_r) = split(k)

    mid = start + offset
    
    (a, b) = eval_partition(arr, mid, k_l, k_r, debug)
    
    nextOffset = floor(Int, offset / 2)
    
    if (a < b) 
        bestScore = a
        nextStart = mid
        n = length(arr)    
        if (nextStart + nextOffset > n - k_r + 1)
            nextOffset = n - k_r + 1 - nextStart
        end
    else
        bestScore = b
        nextStart = start
        if (nextStart + nextOffset < k_l)
            nextOffset = k_l - nextStart
        end
    end
 
    if (nextOffset > 0)
        score = binary_probe(arr, k, nextStart, nextOffset, debug)
        if (score > bestScore)
            bestScore = score
            if (debug)
                selection = newSel
            end
        end
    end
    return bestScore
end


function eval_partition(arr, l, k_l, k_r, debug)
    n = length(arr)
        
    a = solve(arr[1:l], k_l, debug)
    b = solve(arr[l:n], k_r, debug)

    return (a, b)
end


function split(k)
    k_l = round(Int, k/2)
    k_r = k + 1 - k_l
    return (k_l, k_r)
end
