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

  defaults = {}
    
  previousTwoDimensionalArray = root.TwoDimensionalArray

  class TwoDimensionalArray extends Array
    constructor : ( param1, param2, options ) ->
      
      # check if passing vanilla 2d array as param1
      if param1 instanceof Array and param1[0] instanceof Array
        options = param2 or {}
        passThru = true
        len1 = param1.length
        len2 = param1[0].length
      else
        len1 = param1
        len2 = param2

      settings = extend( {}, defaults, options or= {} )

      this.length = len1     
      for e, i in this
        this[i] = []
        this[i].length = len2

      if settings.value? 
        for i in [ 0...len1 ]
          for j in [ 0...len2 ]
            this[i][j] = do ->
              if passThru
                return param1[i][j]
              else if typeof settings.value is "function" 
                return settings.value( i, j )
              else
                return settings.value
          
    # Callback receives ( currentItem, rowIndex, columnIndex, 2dArray )
    forEach : ( callback ) ->
      for row, i in this
        for item, j in row
          callback( item, i, j, this )

    # An alias of forEach
    each : ->
      return this.forEach.apply( this, arguments )

    # Callback receives ( currentItem, rowIndex, columnIndex, 2dArray )
    # Returns a new instance of this class.
    map : ( callback ) ->
      map = new TwoDimensionalArray( @.length, @[0].length )
      for row, i in @
        for item, j in row
          map[i][j] = callback( item, i, j, @ )
      return map

    size : ->
      return [ @.length, @[0].length ]

    at : ( a, b ) ->
      return @[a][b]



  TwoDimensionalArray.noConflict = ->
    root.TwoDimensionalArray = previousTwoDimensionalArray
    @

  return TwoDimensionalArray

)
