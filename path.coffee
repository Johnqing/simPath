$ = jQuery

defaultConfig =
	menu: null
	# 半径 
	radius: 50

	# 弧度
	radian: 360

	# 速度
	speed: 160

	# 触发事件
	event: 'click'

# 缓动公式
$.extend $.easing, 
	easeInQuad: (x, t, b, c, d) ->
		return c * (t /= d) * t + b
	easeOutQuad: (x, t, b, c, d) ->
		return -c * (t /= d) * (t - 2) + b	
	easeInOutQuad: (x, t, b, c, d) ->
		if (t /= d / 2) < 1 
			return c / 2 * t * t + b
		return -c / 2 * ((--t) * (t - 2) - 1) + b
	
	easeInCubic: (x, t, b, c, d) ->
		return c * (t /= d) * t * t + b;
	
	easeOutCubic: (x, t, b, c, d) ->
		return c * ((t = t / d - 1) * t * t + 1) + b
	
	easeInOutCubic: (x, t, b, c, d) ->
		if (t /= d / 2) < 1 
			return c / 2 * t * t * t + b;
		return c / 2 * ((t -= 2) * t * t + 2) + b
	
	easeInQuart: (x, t, b, c, d) ->
		return c * (t /= d) * t * t * t + b
	
	easeOutQuart: (x, t, b, c, d) ->
		return -c * ((t = t / d - 1) * t * t * t - 1) + b
	
	easeInOutQuart: (x, t, b, c, d) ->
		if (t /= d / 2) < 1
			return c / 2 * t * t * t * t + b
		return -c / 2 * ((t -= 2) * t * t * t - 2) + b
	
	easeInQuint: (x, t, b, c, d) ->
		return c * (t /= d) * t * t * t * t + b
	
	easeOutQuint: (x, t, b, c, d) ->
		return c * ((t = t / d - 1) * t * t * t * t + 1) + b
	
	easeInOutQuint: (x, t, b, c, d) ->
		if (t /= d / 2) < 1
			return c / 2 * t * t * t * t * t + b
		return c / 2 * ((t -= 2) * t * t * t * t + 2) + b
	
	easeInSine: (x, t, b, c, d) ->
		return -c * Math.cos(t / d * (Math.PI / 2)) + c + b
	
	easeOutSine: (x, t, b, c, d) ->
		return c * Math.sin(t / d * (Math.PI / 2)) + b
	
	easeInOutSine: (x, t, b, c, d) ->
		return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b
	
	easeInExpo: (x, t, b, c, d) ->
		bx = c * Math.pow(2, 10 * (t / d - 1)) + b
		if t == 0
			bx = b		
		return bx
	
	easeOutExpo: (x, t, b, c, d) ->
		bc = b + c
		if t != d
			bc = c * (-Math.pow(2, -10 * t / d) + 1) + b		
		return bc
	
	easeInOutExpo: (x, t, b, c, d) ->
		if (t == 0) 
			return b
		if (t == d) 
			return b + c
		if (t /= d / 2) < 1
			return c / 2 * Math.pow(2, 10 * (t - 1)) + b
		return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b
	
	easeInCirc: (x, t, b, c, d) ->
		return -c * (Math.sqrt(1 - (t /= d) * t) - 1) + b
	
	easeOutCirc: (x, t, b, c, d) ->
		return c * Math.sqrt(1 - (t = t / d - 1) * t) + b
	
	easeInOutCirc: (x, t, b, c, d) ->
		if (t /= d / 2) < 1
			return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b
		return c / 2 * (Math.sqrt(1 - (t -= 2) * t) + 1) + b
	
	easeInElastic: (x, t, b, c, d) ->		
		s = 1.70158
		p = 0
		a = c
		if t == 0
			return b
		if (t /= d) == 1
			return b + c
		if !p 
			p = d * .3


		if a < Math.abs(c)
			a = c
			s = p / 4
		else 
			s = p / (2 * Math.PI) * Math.asin(c / a)
		return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s) * (2 * Math.PI) / p)) + b
	
	easeOutElastic: (x, t, b, c, d) ->		
		s = 1.70158
		p = 0
		a = c
		if t == 0
			return b;
		if (t /= d) == 1
			return b + c
		if !p
			p = d * .3
		if a < Math.abs(c)
			a = c
			s = p / 4
		else
			s = p / (2 * Math.PI) * Math.asin(c / a)
		return a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p) + c + b


$.fn.path = (opts) ->
	opts = $.extend {}, defaultConfig, opts

	# 没有按钮 直接返回
	if not opts.menu
		return @

	pathItem = $(@)
	menus = $ opts.menu
	easArr = []

	for k of $.easing
		easArr.push(k)

	# 角度转弧度
	radians = Math.PI/180

	# 参数赋值
	radius = opts.radius
	radian = opts.radian

	pathItem.on opts.event, ->
		if $(opts.menu + ':animated').length
			return

		speed = opts.speed
		len = menus.length

		len = len - 1 if radian isnt 360
		
		menus.each (i)->
			item = $(@)
			# 单个元素弧度算法 索引 * 传入的弧度 * 元素的个数 * 半径
			rd = i * radian / len * radians
			x = radius * Math.cos(rd) + 35
			y = radius * Math.sin(rd) + 35 

			# 随机不同效果
			rdNum = Math.floor(Math.random() * easArr.length)
			# 动画延时
			speed += i * 10

			# 旋转
			item.rotate()

			if item.is ':hidden'
				item.show().animate(
					top: [y, easArr[rdNum]]
					left: [x, easArr[rdNum]]
				, speed)
				return
			else 
				item.animate(
					top: [y, easArr[rdNum]]
					left: [x, easArr[rdNum]]
				)
				.animate(
					top: [35, easArr[rdNum]]
					left: [35, easArr[rdNum]]
				, speed, ->
					item.hide()
					return
				)
				return
		return

	return


# 旋转默认配置
rotateConfig = 

	# 速度 
	speed: 1

	# 旋转多少度
	degrees: ''

	time: 0


$.fn.rotate = (opts) -> 
	opts = $.extend {}, rotateConfig, opts

	item = $ @

	degrees = opts.degrees

	currentDegree = 0


	timer = setInterval( ->

		if item.is ':hidden'
			clearInterval timer
			return
		
		if opts.degrees == '' || currentDegree < degrees - 1
			currentDegree += opts.speed
		else
			clearInterval timer
			if opts.degrees != ''
				degrees += opts.degrees

		# 旋转360后恢复为0
		if currentDegree % 360 is 0
			currentDegree = 0;
			degrees = (currentDegree + degrees) % 360;

		item.css(
			'-webkit-transform': 'rotate(' + currentDegree + 'deg)',
			'-moz-transform': 'rotate(' + currentDegree + 'deg)',
			'-ms-transform': 'rotate(' + currentDegree + 'deg)',
			'-o-transform': 'rotate(' + currentDegree + 'deg)',
			'transform': 'rotate(' + currentDegree + 'deg)'
		)
	, opts.time)

	return