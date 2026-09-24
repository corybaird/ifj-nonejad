function v=replication_setting(name,default)

    % Reads an optional REPL_<NAME> environment variable so batch runners can
    % switch toggles (vend, ir, dg, ...) without editing scripts. Environment
    % variables survive the "clear all" at the top of each script.
    s=getenv(['REPL_',upper(name)]);
    if isempty(s)
        v=default;
    else
        v=str2num(s); %#ok<ST2NM> allows vectors such as "[1,2,3]"
    end

end
