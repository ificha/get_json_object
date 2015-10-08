
-- get json attr value
CREATE FUNCTION get_json_object (@eventattrs nvarchar(4000), @attr_name nvarchar(100))
RETURNS nvarchar(4000)
AS
BEGIN
    
	-- out value
	DECLARE @val nvarchar(4000) = null;

	-- get attr name start index
	DECLARE @start_idx int = patindex('%"' + @attr_name + '"%', @eventattrs);
	IF @start_idx != 0
		BEGIN

			-- get substr: "atr":"val"
			DECLARE @atr_val_str nvarchar(4000) = SUBSTRING(@eventattrs, @start_idx, LEN(@eventattrs) - @start_idx);

			-- get idx for :
			DECLARE @colon_idx int = CHARINDEX(':', @atr_val_str);
			IF @colon_idx != 0
				BEGIN

					-- get value end index
					DECLARE @end_idx int = CHARINDEX(',', @atr_val_str) - 1;
					IF @end_idx = -1
						SET @end_idx = LEN(@atr_val_str);

					-- get value and trim left & right
					SET @val = SUBSTRING(@atr_val_str, @colon_idx + 1, @end_idx - @colon_idx);
					SET @val = RTRIM(LTRIM(@val));
		
					-- remove " from begining and end
					IF SUBSTRING(@val, 1, 1) = '"'
						SET @val = SUBSTRING(@val, 2, LEN(@val))

					IF SUBSTRING(@val, LEN(@val), 1) = '"'
						SET @val = SUBSTRING(@val, 1, LEN(@val) - 1)

				END
	END

	RETURN(@val);

END;
