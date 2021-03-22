--高速决斗技能-抽卡预感：地
Duel.LoadScript("speed_duel_common.lua")
function c100730082.initial_effect(c)82
	aux.SpeedDuelMoveCardToFieldCommon(4869446,c)
	if not c100730082.UsedLP then
		c100730082.UsedLP={}
		c100730082.UsedLP[0]=0
		c100730082.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730082.skill,c100730082.con,aux.Stringid(100730082,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730082.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730082,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730082)
		c100730082.UsedLP[tp]=c100730082.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_EARTH)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730082.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_EARTH)>0
		and aux.DecreasedLP[tp]-c100730082.UsedLP[tp] >= 1500
end