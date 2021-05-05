--高速决斗技能-被双神选中的男人
Duel.LoadScript("speed_duel_common.lua")
function c100730117.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730117.skill,c100730117.con,aux.Stringid(100730117,0))
	aux.SpeedDuelMoveCardToDeckCommon(39823987,c)
	aux.SpeedDuelMoveCardToDeckCommon(66818682,c)
	aux.SpeedDuelMoveCardToDeckCommon(41181774,c)
	aux.SpeedDuelMoveCardToDeckCommon(37910722,c)
	aux.SpeedDuelMoveCardToDeckCommon(25472513,c)
	aux.SpeedDuelMoveCardToDeckCommon(1686814,c)
	aux.SpeedDuelMoveCardToDeckCommon(90884403,c)
	aux.SpeedDuelMoveCardToDeckCommon(60025883,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730117.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,41181774)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,39823987)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,66818682)
		and Duel.GetMZoneCount(tp)>0
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>=2
end

function c100730117.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,1,nil,41181774)
	local c=g:Select(tp,1,1,nil)
	if c then
	   Duel.ConfirmCards(1-tp,c)
	   Duel.Hint(HINT_CARD,1-tp,100730117)
		local e1=Effect.CreateEffect(e:GetHandler(c))
		e1:SetDescription(aux.Stringid(100730117,0))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(LOCATION_HAND,0)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetTarget(c100730117.nttg)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local d1=Duel.CreateToken(tp,44710391)
		Duel.MoveToField(d1,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		local d2=Duel.CreateToken(tp,91468551)
		Duel.MoveToField(d2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local d3=Duel.CreateToken(tp,70109009)
		Duel.MoveToField(d3,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	Duel.ShuffleHand(tp)
	e:Reset()
end
function c100730117.nttg(e,c)
	return c:IsCode(41181774)
end