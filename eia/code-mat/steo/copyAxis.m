function copyAxis(a, b)
    p =  properties(a).';
    for i=1:numel(p)  %copy all public properties
        try   %may fail if property is read-only
            b.(p{i}) = a.(p{i});
        catch
            warning('failed to copy property: %s', p{i});
        end
    end
end