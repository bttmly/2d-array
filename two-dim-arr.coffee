( ( root, factory ) ->
  if typeof define is "function" and define.amd
    define [
      "exports"
    ], ( _, exports ) ->
      root.TwoDimensionalArray = factory( root, exports )
      return  

  else if typeof exports isnt "undefined"
    factory( root, exports )

  else
    root.TwoDimensionalArray = factory( root, {} )

  return

)( this, ( root, TwoDimensionalArray ) ->  
  
  # http://youmightnotneedjquery.com/#extend
  extend = ( out ) ->
    out or= {}
    for arg in arguments
      continue unless arg
      for own key, val of arg
        out[key] = val
    return out

  defaults =
    value : false
    

  class TwoDimensionalArray extends Array
    constructor : ( param1, param2, options ) ->
      
      settings = extend( {}, defaults, ( options or= {} ) )
      
      # see if we're passing in a vanilla 2d array
      # if param1 instanceof Array and param1[0] instanceof Array
        
      this.length = x     
      for i in [ 0...x ]
        this[i] = []
        this[i].length = y

      if settings.value? 
        for j in [ 0... y ]
          this[i][j] = if typeof settings.value is "function" then settings.value( i, j ) else settings.value
          
    # Callback receives ( currentItem, rowIndex, columnIndex, 2dArray )
    forEach : ( callback ) ->
      for row, i in this
        for item, j in row
          callback( item, i, j, this )

    # An alias to forEach
    each : ->
      return this.forEach.apply( this, arguments )

    # Callback receives ( currentItem, rowIndex, columnIndex, 2dArray )
    # Returns a new instance of this class.
    map : ( callback ) ->
      map = new TwoDimensionalArray( this.length, this[0].length )
      for row, i in this
        for item, j in row
          map[i][j] = callback( item, i, j, this )

    size : ->
      return [ this.length, this[0].length ]

)
