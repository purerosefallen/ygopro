--高速决斗技能-龙之融合
Duel.LoadScript("speed_duel_common.lua")
function c100730059.initial_effect(c)
	aux.SpeedDuelMoveCardToDeckCommon(99267150,c)
	aux.SpeedDuelMoveCardToDeckCommon(10669138,c)
	aux.SpeedDuelMoveCardToDeckCommon(75906310,c)
	aux.SpeedDuelMoveCardToDeckCommon(71490127,c)
	if not c100730059.UsedLP then
		c100730059.UsedLP={}
		c100730059.UsedLP[0]=0
		c100730059.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730059.skill,c100730059.con,aux.Stringid(100730059,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730059.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
		and aux.DecreasedLP[tp]-c100730059.UsedLP[tp]>=1500
end
function c100730059.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	c100730059.UsedLP[tp]=c100730059.UsedLP[tp]+1500
	Duel.Hint(HINT_CARD,1-tp,100730059)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local c=Duel.CreateToken(tp,71490127)
	Duel.SendtoHand(c,nil,REASON_RULE)
	if Duel.IsExistingMatchingCard(c100730059.Isyubel,tp,LOCATION_MZONE,0,1,nil) then
		local g=Duel.SelectMatchingCard(tp,c100730059.Isyubel,tp,LOCATION_MZONE,0,1,1,nil)
		local tc=g:GetFirst()
		if tc:IsOriginalCodeRule(99267150) then code=10669138 end
		if tc:IsOriginalCodeRule(10669138) then code=75906310 end
		local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,code)
		if g2:GetCount()>0 then
			Duel.SendtoDeck(tc,nil,0,REASON_RULE)
			Duel.SpecialSummon(g2,0,tp,tp,true,false,POS_FACEUP_ATTACK)
		end
	end
end
function c100730059.Isyubel(c)
	return c:IsOriginalCodeRule(99267150,10669138) and c:IsFaceup()
end