--高速决斗技能-宇宙启示
Duel.LoadScript("speed_duel_common.lua")
function c100730161.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(91654806,c)
	if not c100730161.UsedLP then
		c100730161.UsedLP={}
		c100730161.UsedLP[0]=0
		c100730161.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730161.skill,c100730161.con,aux.Stringid(100730161,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730161.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730161,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730161)
		c100730161.UsedLP[tp]=c100730161.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_PSYCHO)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730161.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_PSYCHO)>0
		and aux.DecreasedLP[tp]-c100730161.UsedLP[tp] >= 1000
end