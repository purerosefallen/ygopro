--高速决斗技能-魔力流通
Duel.LoadScript("speed_duel_common.lua")
function c100730011.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(51481927,c)
	if not c100730011.UsedLP then
		c100730011.UsedLP={}
		c100730011.UsedLP[0]=0
		c100730011.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730011.skill,c100730011.con,aux.Stringid(100730011,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730011.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730011,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730011)
		c100730011.UsedLP[tp]=c100730011.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_DECK,0,nil,RACE_SPELLCASTER)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730011.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_DECK,0,nil,RACE_SPELLCASTER)>0
		and aux.DecreasedLP[tp]-c100730011.UsedLP[tp] >= 1500
end