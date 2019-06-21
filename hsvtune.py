import cv2
import numpy as np

def nothing():
    pass

cv2.namedWindow('image')  

cap = cv2.VideoCapture(0)
#cap = cv2.imread('iris.jpg')

cv2.createTrackbar('H_Lo','image', 0, 255, nothing)
cv2.createTrackbar('H_Up','image', 51, 255, nothing)
cv2.createTrackbar('S_Lo','image', 0, 255, nothing)
cv2.createTrackbar('S_Up','image', 255, 255, nothing)
cv2.createTrackbar('V_Lo','image', 255, 255, nothing)
cv2.createTrackbar('V_Up','image', 255, 255, nothing)  

while(1):

    _, frame = cap.read()
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    #frame = cap
    #hsv = cv2.cvtColor(cap, cv2.COLOR_BGR2HSV)


    hLo = cv2.getTrackbarPos('H_Lo', 'image')
    hUp = cv2.getTrackbarPos('H_Up', 'image')
    sLo = cv2.getTrackbarPos('S_Lo', 'image')
    sUp = cv2.getTrackbarPos('S_Up', 'image')
    vLo = cv2.getTrackbarPos('V_Lo', 'image')
    vUp = cv2.getTrackbarPos('V_Up', 'image')

    lower_blue = np.array([hLo,sLo,vLo])
    upper_blue = np.array([hUp,sUp,vUp])

    
    mask = cv2.inRange(hsv, lower_blue, upper_blue)

    res = cv2.bitwise_and(frame, frame, mask= mask)

    res2 = cv2.cvtColor(res, cv2.COLOR_BGR2GRAY)
    res2 = cv2.medianBlur(res2, 15)

    contours, hier = cv2.findContours(res2, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    if len(contours) != 0:
    	#find the biggest area
    	c = max(contours, key = cv2.contourArea)
    	(x, y), radius = cv2.minEnclosingCircle(c)
    	# convert all values to int
    	center = (int(x), int(y))
    	radius = int(radius)
    	# and draw the circle in blue
    	frame = cv2.circle(frame, center, radius, (255, 0, 0), 2)
    	frame = cv2.circle(frame, center, 5, (255, 0, 0), 5)
    	frame = cv2.line(frame, (320, 250), (320, 230), (0,0,255), 2)
    	frame = cv2.line(frame, (310, 240), (330, 240), (0,0,255), 2)

    cv2.imshow('frame', frame)
    pX = x - 320
    pY = y - 240
    print('x: ' + str(int(pX)) + '  y: ' + str(int(pY)))
    cv2.imshow('mask', mask)
    cv2.imshow('res',res)
    cv2.imshow('res2',res2)
    cv2.imshow('HSV Img', hsv)

    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break
cv2.imwrite('mask.jpg', mask)
cv2.imwrite('res.jpg', res)
cv2.imwrite('res2.jpg', res2)

cv2.destroyAllWindows()        