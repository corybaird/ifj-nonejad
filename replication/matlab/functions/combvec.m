function y = combvec(varargin)
if nargin == 0
    y = [];
    return;
end
y = varargin{1};
for i = 2:nargin
    b = varargin{i};
    y = [repmat(y, 1, size(b, 2)); reshape(repmat(b, size(y, 2), 1), size(b, 1), [])];
end
end
