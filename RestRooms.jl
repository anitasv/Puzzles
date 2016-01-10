
function solve(arr, k, debug)
    n = length(arr)
    
    if (k == 2)
        if (debug)
            return (arr[n] - arr[1], [arr[1], arr[n]])
        else
            return arr[n] - arr[1]
        end
    end
            
    if (debug)
        (status, score, selection) = binary_probe(arr, k, 1, floor(Int, n / 2), debug)
        return (score, selection)
    else
        (status, score) = binary_probe(arr, k, 1, floor(Int, n / 2), debug)
        return score
    end
end

function binary_probe(arr, k, start, offset, debug)
   
    (k_l, k_r) = split(k)

    mid = start + offset
    
    if (debug)
        (stat, a, b, selection) = eval_partition(arr, mid, k_l, k_r, debug)
    else
        (stat, a, b) = eval_partition(arr, mid, k_l, k_r, debug)
    end
    
    if (!stat) 
        if (debug)
            return (false, 0, [])
        else
            return (false, 0)
        end
    end
    
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
        if (debug)
            (status, score, newSel) = binary_probe(arr, k, nextStart, nextOffset, debug)
        else
            (status, score) = binary_probe(arr, k, nextStart, nextOffset, debug)
        end
        if (status)
            if (score > bestScore)
                if (debug)
                    return (true, score, newSel)
                else
                    return (true, score)
                end
            end
        end
    end
    if (debug)
        return (true, bestScore, selection)
    else
        return (true, bestScore)
    end
end


function eval_partition(arr, l, k_l, k_r, debug)
    n = length(arr)
    
    if (k_l > l || k_r > n - l + 1)
        if (debug)
            println("(1, $l, $k_l) and ($l, $n, $k_r) => Invalid")
            return (false, 0, 0, [])
        else
            return (false, 0, 0)
        end
    end
        
    if (debug)
        (a, sela) = solve(arr[1:l], k_l, debug)
        (b, selb) = solve(arr[l:n], k_r, debug)
    else
        a = solve(arr[1:l], k_l, debug)
        b = solve(arr[l:n], k_r, debug)
    end
        
    if (debug)
        newSel = vcat(sela[1:(k_l-1)], selb)
        println("(1, $l, $k_l) and ($l, $n, $k_r) => ($a, $b, $newSel)")
        return (true, a, b, newSel)
    else
        return (true, a, b)
    end
end


function split(k)
    k_l = round(Int, k/2)
    k_r = k + 1 - k_l
    return (k_l, k_r)
end


R=[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89];

solve(R, 4, true);

ans

solve(R, 4, false)


