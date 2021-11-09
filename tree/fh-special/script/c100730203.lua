--高速决斗技能-平衡
Duel.LoadScript("speed_duel_common.lua")
function c100730203.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(92481084,c)
	aux.SpeedDuelBeforeDraw(c,c100730203.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730203.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730203)
	if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_HAND+LOCATION_DECK,0,nil,TYPE_MONSTER)<6 then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730203,0))
		e:Reset()
		return
	end
	if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_HAND+LOCATION_DECK,0,nil,TYPE_SPELL)<6 then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730203,1))
		e:Reset()
		return
	end
	if Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_HAND+LOCATION_DECK,0,nil,TYPE_TRAP)<6 then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730203,2))
		e:Reset()
		return
	end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	if not g then return end
	local count=aux.SpeedDuelSendToDeckWithExile(tp,g)
	local gm=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_MONSTER)
	local gs=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_SPELL)
	local gt=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_TRAP)
	local gmc=gm:GetCount()
	local gsc=gm:GetCount()
	local gtc=gm:GetCount()
	local sum=gmc+gsc+gtc

	local resultM=count/sum*gmc
	local resultMInt=math.floor(resultM)
	local resultMSpare=resultM-resultMInt
	local resultS=count/sum*gsc
	local resultSInt=math.floor(resultS)
	local resultSSpare=resultS-resultSInt
	local resultT=count/sum*gtc
	local resultTInt=math.floor(resultT)
	local resultTSpare=resultS-resultSInt

	local gResult=Group.CreateGroup()
	local gtmp=gm:RandomSelect(tp,resultMInt)
	gResult:Merge(gtmp)
	gm:Sub(gtmp)
	
	gtmp=gs:RandomSelect(tp,resultSInt)
	gResult:Merge(gtmp)
	gs:Sub(gtmp)

	gtmp=gt:RandomSelect(tp,resultTInt)
	gResult:Merge(gtmp)
	gt:Sub(gtmp)

	count=count-gResult:GetCount()

	local most=Group.CreateGroup()
	local second=Group.CreateGroup()

	if resultMSpare>=resultSSpare and resultMSpare>=resultTSpare then
		most:Merge(gm)
	end

	if (resultMSpare>=resultSSpare and resultMSpare<resultTSpare) or (resultMSpare<resultSSpare and resultMSpare>=resultTSpare)
		or (resultMSpare<resultSSpare and resultMSpare<resultTSpare and resultSSpare==resultTSpare) then
		second:Merge(gm)
	end

	if resultSSpare>=resultMSpare and resultSSpare>=resultTSpare then
		most:Merge(gs)
	end

	if (resultSSpare>=resultMSpare and resultSSpare<resultTSpare) or (resultSSpare<resultMSpare and resultSSpare>=resultTSpare)
		or (resultSSpare<resultMSpare and resultSSpare<resultTSpare and resultMSpare==resultTSpare) then
		second:Merge(gs)
	end

	if resultTSpare>=resultSSpare and resultTSpare>=resultMSpare then
		most:Merge(gt)
	end

	if (resultTSpare>=resultSSpare and resultTSpare<resultMSpare) or (resultTSpare<resultSSpare and resultTSpare>=resultMSpare)
		or (resultTSpare<resultMSpare and resultTSpare<resultSSpare and resultSSpare==resultTSpare) then
		second:Merge(gt)
	end
	
	gtmp=most:RandomSelect(tp,1)
	gResult:Merge(gtmp)

	if count>1 then

		most:Sub(gtmp)

		if second:GetCount()==0 then
			second:Merge(most)
		end

		gtmp=second:RandomSelect(tp,1)
		gResult:Merge(gtmp)

	end

	aux.SpeedDuelSendToHandWithExile(tp,gResult)
	
	e:Reset()
end
