function  point = randomPointInSphere( radius )
    done = false;
    point = 2 * radius * (rand([3 1]) - 0.5);
    while (~done)
        % If point not in sphere, draw again
        if ( sqrt(sum(point.^2)) <= radius )
            done = true;
        else
            point = 2 * radius * (rand([3 1]) - 0.5);
        end
    end

end

