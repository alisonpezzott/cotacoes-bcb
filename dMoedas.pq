let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("jZFLbsIwEECvEjksQEqr7FlBk7R8BAiUBYpYTBOrigi2GOMLcBVUdQMrbkBuwkk6BrnOCrqaj9/TeDRZxnppxAIW1ecK0AOtdghVCUJSs+UHvh++hmG3/Zd2ui9sFWTsrdfQchBQcKH4M+kjISJBELn0lK5P9Y+ZQ20nNQqrRaORoSRK8IpSwAZwq7kCaq7RmS63YpzOiYk1minX/dGxjcLC7/0ZUePyE8GL1Y5jRaOoczk4zeXWGs6WxAy4MLtfvm/PxN0TC02mbgEhUfOvf31/ETtNaZ4/N9JF4yqFVGYRMDEVJYVH51n9Ag==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Moeda = _t, Nome = _t, Formatacao = _t])
in
    Source
