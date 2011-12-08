/**
 *  GameControlChipmunk.cpp
 *  ChinesePuzzle
 *
 *  Created by Mathieu LEDRU on 01/11/11.
 *
 *  GPL License:
 *  Copyright (c) 2011, Mathieu LEDRU
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include "GameControlChipmunk.h"
#include "Card.h"
#include "Game.h"

#include "cpConfig.h"
#include "cpDrawSpace.h"

static cpDrawSpaceOptions cpDrawSpaceOpts = {
	1,//Draw Hash
	1,//Draw BBoxes
	1,//Draw Shapes
	4.0f,//Collision Point Size
	1.0f,//Body Point Size
	1.5f//Line Thickness
};

static bool cpInit = false;

using namespace cocos2d;

//chipmunk callbacks
void cpSpriteBodyUpdatePosition(cpBody *body, cpFloat dt)
{
    CCSprite* sprite = body->data;
	body->p.x = sprite->getPosition().x;
	body->p.y = sprite->getPosition().y;
}

GameControlChipmunk::GameControlChipmunk()
{
	if(!cpInit)
	{
		cpInitChipmunk(); //init chipmunk lib
		cpInit = true;
	}
	
	this->space = cpSpaceNew();
}

GameControlChipmunk::~GameControlChipmunk()
{
	cpSpaceFree(space);
    space = NULL;
}

void GameControlChipmunk::step(ccTime dt)
{
	cpSpaceStep(space, dt);
}

void GameControlChipmunk::draw()
{
	cpDrawSpace(space, &cpDrawSpaceOpts);
}

void GameControlChipmunk::addCard(Card* card)
{
	this->removeCard(card);
	
	//chipmunk
	float mass = 1.0;
	
	cpBody* body = cpBodyNew(mass, cpMomentForBox(mass, card->getContentSize().width, card->getContentSize().height));
	body->data = card;
	body->position_func = cpSpriteBodyUpdatePosition;
	cpSpaceAddBody(space, body);
	
	cpShape* shape = cpBoxShapeNew(body, card->getContentSize().width, card->getContentSize().height);
	cpSpaceAddShape(space, shape);
	
	cards.insert(pair<Card*, cpShape*>(card, shape));
	card->addCardDelegate(this);
	this->updateCard(card);
}

void GameControlChipmunk::removeCard(Card* card)
{
	CardCpMap::iterator it = cards.find(card);
	if(it != cards.end())
	{
		cpSpaceRemoveShape(space, it->second);
		cards.erase(card);
		card->removeCardDelegate(this);
	}
}

void GameControlChipmunk::updateCard(Card* card)
{
	CardCpMap::iterator it = cards.find(card);
	if(it != cards.end())
	{
		cpSpriteBodyUpdatePosition(it->second->body, 0);
	}
}

Card* GameControlChipmunk::getCard(CCPoint p)
{
	cpVect cpP = {p.x, p.y};
    cpShape* shape = cpSpacePointQueryFirst(space, cpP, CP_ALL_LAYERS, CP_NO_GROUP);
    if(shape && shape->body->data)
    {
        return shape->body->data;
	}
	
	return NULL;
}